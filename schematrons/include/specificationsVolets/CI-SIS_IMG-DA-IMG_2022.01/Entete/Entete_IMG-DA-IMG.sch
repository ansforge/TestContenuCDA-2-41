<?xml version="1.0" encoding="UTF-8"?>

<!--                  
    Entete_IMG-DA-IMG.sch
    Teste la conformité de l'entete du volet IMG-DA-IMG au CI-SIS
    
    Historique :
    05/01/2022 : ANS : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="Entete_IMG-DA-IMG">

    <rule context='cda:ClinicalDocument'>
        
        <!-- Conformité specifications IMG-DA-IMG -->
        <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.47']"> 
            [CI-SIS_IMG-DA-IMG] Erreur de conformité aux specifications IMG-DA-IMG: Le templateId "1.2.250.1.213.1.1.1.47" doit être présent.
        </assert>
       <!-- Conformité CDA Imaging Report (DICOM part20) -->
        <assert test="cda:templateId[@root='1.2.840.10008.9.1']"> 
            [CI-SIS_IMG-DA-IMG] Erreur de conformité CDA Imaging Report (DICOM part20) : Le templateId "1.2.840.10008.9.1" doit être présent.
        </assert>
        <!-- Conformité General Header (DICOM part20) -->
        <assert test="cda:templateId[@root='1.2.840.10008.9.20']"> 
            [CI-SIS_IMG-DA-IMG] Erreur de conformité General Header (DICOM part20) : Le templateId "1.2.840.10008.9.20" doit être présent.
        </assert>
        <!-- Conformité au Imaging Header (DICOM part20) -->
        <assert test="cda:templateId[@root='1.2.840.10008.9.21']"> 
            [CI-SIS_IMG-DA-IMG] Erreur de conformité au Imaging Header (DICOM part20) : Le templateId "1.2.840.10008.9.21" doit être présent.
        </assert>
        
        <!-- Type de document -->
        <assert test="cda:code[@code='55115-0' and @codeSystem='2.16.840.1.113883.6.1']">
            [Entete_IMG-DA-IMG] L'élément "code" du document IMG-DA-IMG doit avoir les attributs @code="55115-0" et @codeSystem="2.16.840.1.113883.6.1". 
        </assert>
    </rule>      
           
    <rule context="cda:ClinicalDocument/cda:documentationOf">
        <assert test="cda:serviceEvent/cda:code[@code='55115-0' and @codeSystem='2.16.840.1.113883.6.1']">
            [Entete_IMG-DA-IMG] Le code de l'acte documenté est obligatoire et doit avoir l'attribut @code="55115-0" et @codeSystem="2.16.840.1.113883.6.1".       
        </assert>
    </rule>
  
</pattern>