<?xml version="1.0" encoding="UTF-8"?>

<!--                  
    Entete_IMG-CR-IMG.sch
    Teste la conformité de l'entete du volet IMG-CR-IMG au CI-SIS
    
    Historique :
    24/03/2021 : ANS : Création
    29/04/2021 : ANS : Suppression du controle sur la balise title
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="Entete_IMG-CR-IMG">
    
    <rule context='cda:ClinicalDocument'>
        
        <!-- Conformité specifications IMG-CR-IMG -->
        <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.45']"> 
            [CI-SIS_IMG-CR-IMG] Erreur de conformité aux specifications IMG-CR-IMG: Le templateId "1.2.250.1.213.1.1.1.45" doit être présent.
        </assert>
       <!-- Conformité CDA Imaging Report (DICOM part20) -->
        <assert test="cda:templateId[@root='1.2.840.10008.9.1']"> 
            [CI-SIS_IMG-CR-IMG] Erreur de conformité CDA Imaging Report (DICOM part20) : Le templateId "1.2.840.10008.9.1" doit être présent.
        </assert>
        <!-- Conformité General Header (DICOM part20) -->
        <assert test="cda:templateId[@root='1.2.840.10008.9.20']"> 
            [CI-SIS_IMG-CR-IMG] Erreur de conformité General Header (DICOM part20) : Le templateId "1.2.840.10008.9.20" doit être présent.
        </assert>
        <!-- Conformité au Imaging Header (DICOM part20) -->
        <assert test="cda:templateId[@root='1.2.840.10008.9.21']"> 
            [CI-SIS_IMG-CR-IMG] Erreur de conformité au Imaging Header (DICOM part20) : Le templateId "1.2.840.10008.9.21" doit être présent.
        </assert>
        
        <!-- Type de document -->
        <assert test="cda:code[@code='18748-4' and @codeSystem='2.16.840.1.113883.6.1']">
            [Entete_IMG-CR-IMG] L'élément "code" du document IMG-CR-IMG doit avoir les attributs @code="18748-4" et @codeSystem="2.16.840.1.113883.6.1". 
        </assert>
        
        <!-- Acte documenté -->
        <assert test="count(cda:documentationOf)&gt;=1">
            [Entete_IMG-CR-IMG] L'élément "documentationOf" du document IMG-CR-IMG est obligatoire [1..*].
        </assert>
        
        <!-- infulfillmentOf -->
        <assert test="count(cda:inFulfillmentOf)&gt;=1">
            [Entete_IMG-CR-IMG] L'élément "infulfillmentOf" du document IMG-CR-IMG est obligatoire [1..*].
        </assert>
    </rule>      
           
    <rule context="cda:ClinicalDocument/cda:documentationOf">
        <assert test="cda:serviceEvent/cda:code">
            [Entete_IMG-CR-IMG] Le code de l'acte documenté est obligatoire.            
        </assert>
       <!-- <assert test="cda:serviceEvent/cda:code/@code = //cda:procedure[cda:templateId/@root='1.2.250.1.213.1.1.3.153']/cda:code/@code">
            [Entete_IMG-CR-IMG] L'élément 'cda:documentationOf/cda:serviceEvent/cda:code/@code' doit correspondre à l'élement code de l'entrée FR-DICOM-Technique-imagerie de la section FR-DICOM-Acte-imagerie.
        </assert>-->
        <assert test="count(cda:serviceEvent/cda:code/cda:translation) &gt;=1">
            [Entete_IMG-CR-IMG] L'élement documentationOf de l'acte documenté doit avoir au minimum une translation : [0..1] pour le code CCAM de l'acte documenté, une ou plusieurs [1..*] pour la modalité d'imagerie
             , [0..1] pour la localisation anatomique.            
        </assert>
    </rule>
    
    <rule context="cda:ClinicalDocument/cda:inFulfillmentOf">
        <assert test="cda:order">
            [Entete_IMG-CR-IMG] L'élément order est obligatoire [1..1].            
        </assert>
        <assert test="cda:order/cda:id">
            [Entete_IMG-CR-IMG] L'élément id est obligatoire [1..1].            
        </assert>
        <assert test="cda:order/ps3-20:accessionNumber">
            [Entete_IMG-CR-IMG] L'élément accessionNumber est obligatoire [1..1].            
        </assert>
    </rule>
  
</pattern>