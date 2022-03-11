<?xml version="1.0" encoding="UTF-8"?>

<!-- 
   ......................................................................................................................................................    
  E_ExamenImagerie_IMG-CR-IMG.sh
   Schématron de vérification de la conformité au modèle du CI-SIS l'entrée FR-DICOM-Examen-imagerie(1.2.250.1.213.1.1.3.155) dans le document IMG-CR-IMG qui décrit 
   l'examen d'imagerie.
   
   IMG-CR-IMG : Compte rendu d'imagerie
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    06/04/2021 : SBM : Création
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_ExamenImagerie_IMG-CR-IMG">
    
    
    <rule context="cda:act[cda:templateId/@root='1.2.250.1.213.1.1.3.155']"> 
        
        <!-- Vérifier l'identifiant de l'entrée 'FR-DICOM-Examen-imagerie'-->
        <assert test=".//cda:id">
            [E_ExamenImagerie_IMG-CR-IMG] Erreur de conformité au modèle IMG-CR-IMG : l'entrée FR-DICOM-Examen-imagerie (1.2.250.1.213.1.1.3.155) doit obligatoirement contenir l'identifiant de l'examen d'imagerie : id [1..1].
        </assert>
        
        <!-- Vérifier la cardinalité de l'entrée 'FR-DICOM-Serie-imagerie' [1..*] -->
        <assert test="count(.//cda:entryRelationship[@typeCode='COMP']/cda:act[cda:templateId/@root='1.2.250.1.213.1.1.3.156'])&gt;=1">
            [E_ExamenImagerie_IMG-CR-IMG] Erreur de conformité au modèle IMG-CR-IMG : l'entrée FR-DICOM-Examen-imagerie (1.2.250.1.213.1.1.3.155) doit obligatoirement contenir un ou plusieurs entrée(s) FR-DICOM-Serie-imagerie(1.2.250.1.213.1.1.3.156) [1..*].
        </assert>
    </rule>
    
    <rule context="cda:act[cda:templateId/@root='1.2.250.1.213.1.1.3.156']"> 
        
        <!-- Vérifier l'identifiant de l'entrée 'FR-DICOM-Serie-imagerie'-->
        <assert test=".//cda:id">
            [E_ExamenImagerie_IMG-CR-IMG] Erreur de conformité au modèle IMG-CR-IMG : l'entrée FR-DICOM-Serie-imagerie (1.2.250.1.213.1.1.3.156) doit obligatoirement contenir l'identifiant de la série d'imagerie : id [1..1].
        </assert>
        
        <!-- Vérifier le code de l'entrée 'FR-DICOM-Serie-imagerie'-->
        <assert test=".//cda:code/@code='113015' and .//cda:code/@codeSystem='1.2.840.10008.2.16.4'">
            [E_ExamenImagerie_IMG-CR-IMG] Erreur de conformité au modèle IMG-CR-IMG : l'entrée FR-DICOM-Serie-imagerie (1.2.250.1.213.1.1.3.156) doit obligatoirement avoir comme code : @code='113015' et @codeSystem='1.2.840.10008.2.16.4'
        </assert>
        
        <!-- Vérifier le code/qualifier/name de l'entrée 'FR-DICOM-Serie-imagerie'-->
        <assert test=".//cda:code/cda:qualifier/cda:name/@code='121139' and .//cda:code/cda:qualifier/cda:name/@codeSystem='1.2.840.10008.2.16.4'">
            [E_ExamenImagerie_IMG-CR-IMG] Erreur de conformité au modèle IMG-CR-IMG : l'entrée FR-DICOM-Serie-imagerie (1.2.250.1.213.1.1.3.156) doit obligatoirement avoir comme code/qualifier/name : @code='121139' et @codeSystem='1.2.840.10008.2.16.4'
        </assert>
        
        <!-- Vérifier le code/qualifier/value de l'entrée 'FR-DICOM-Serie-imagerie'-->
        <assert test="count(.//cda:code/cda:qualifier/cda:value)=1">
            [E_ExamenImagerie_IMG-CR-IMG] Erreur de conformité au modèle IMG-CR-IMG : l'entrée FR-DICOM-Serie-imagerie (1.2.250.1.213.1.1.3.156) doit obligatoirement avoir l'élément code/qualifier/value [1..1]
        </assert>
        <!-- Vérifier la cardinalité de l'entrée 'FR-DICOM-SOP-instance-observation' [1..*] -->
        <assert test="count(.//cda:entryRelationship[@typeCode='COMP']/cda:observation[cda:templateId/@root='1.2.250.1.213.1.1.3.157'])&gt;=1">  
            [E_ExamenImagerie_IMG-CR-IMG] Erreur de conformité au modèle IMG-CR-IMG : l'entrée FR-DICOM-Serie-imagerie (1.2.250.1.213.1.1.3.156) doit obligatoirement contenir un ou plusieurs entrée(s) FR-DICOM-SOP-instance-observation(1.2.250.1.213.1.1.3.157) [1..*].
        </assert>
    </rule>
    
    
    <rule context="cda:observation[cda:templateId/@root='1.2.250.1.213.1.1.3.157']"> 
        
        <!-- Vérifier l'attribut @classCode de l'élément observation de l'entrée FR-DICOM-SOP-instance-observation -->
        <assert test="@classCode='DGIMG'">
            [E_ExamenImagerie_IMG-CR-IMG] Erreur de conformité au modèle IMG-CR-IMG : l'élément observation de l'entrée FR-DICOM-SOP-instance-observation (1.2.250.1.213.1.1.3.157) doit obligatoirement avoir comme attribut @classCode='DGIMG'.
        </assert>
        
        <!-- Vérifier le code de l'entrée FR-DICOM-SOP-instance-observation -->
        <assert test="./cda:code">
            [E_ExamenImagerie_IMG-CR-IMG] Erreur de conformité au modèle IMG-CR-IMG : l'entrée FR-DICOM-SOP-instance-observation (1.2.250.1.213.1.1.3.157) doit obligatoirement contenir l'élément code [1..1].
        </assert>
        
        <!-- Vérifier les références WADO (lien vers les images) de l'entrée FR-DICOM-SOP-instance-observation -->
        <assert test="not(.//cda:text[@mediaType='application/dicom']) or (.//cda:text/@mediaType='application/dicom' and .//cda:text[@mediaType='application/dicom']/cda:reference)">
            [E_ExamenImagerie_IMG-CR-IMG] Erreur de conformité au modèle IMG-CR-IMG : l'élément text s'il existe dans l'entrée FR-DICOM-SOP-instance-observation (1.2.250.1.213.1.1.3.157) doit avoir obligatoirement
             l'élément 'reference' pour faire les liens vers les images.
        </assert>
    </rule>
    
    <rule context="cda:observation[cda:templateId/@root='1.2.250.1.213.1.1.3.157']/cda:text"> 
        <!-- Vérifier l'attribut @classCode de l'élément observation de l'entrée FR-DICOM-SOP-instance-observation -->
        <assert test="@mediaType='application/dicom'">
            [E_ExamenImagerie_IMG-CR-IMG] Erreur de conformité au modèle IMG-CR-IMG : l'élément text s'il existe dans l'entrée FR-DICOM-SOP-instance-observation (1.2.250.1.213.1.1.3.157) doit avoir obligatoirement
            l'attribut @mediaType='application/dicom'
        </assert>
    </rule>
</pattern>