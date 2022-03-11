<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    E_FR-Isolat-microbiologique.sch :
    
    Vérification de la conformité d'une entrée FR-Isolat-microbiologique (1.3.6.1.4.1.19376.1.3.1.5) 
    
    Historique :
    13/01/2021 : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_FR-Isolat-microbiologique">
    <p>Vérification de la conformité d'une entrée FR-Isolat-microbiologique (1.3.6.1.4.1.19376.1.3.1.5)</p>
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.3.1.5']">
        
        <assert test="self::cda:organizer and @classCode = 'CLUSTER' and @moodCode = 'EVN'">
            [E_FR-Isolat-microbiologique] Erreur de conformité :
            Un isolat biologique dans une entry (1.3.6.1.4.1.19376.1.3.1.5)
            doit être un organizer de classCode CLUSTER et de moodCode EVN. 
        </assert>      
        
        <assert test="cda:statusCode[@code = 'completed'] or
                    cda:statusCode[@code = 'active'] or
                    cda:statusCode[@code = 'aborted']"> 
            [E_FR-Isolat-microbiologique] Erreur de conformité :
            Un isolat biologique doit avoir un statusCode@code valant 'completed', 'active' ou 'aborted'. 
        </assert>
     
        <assert test="cda:specimen[@typeCode='SPC']">
            [E_FR-Isolat-microbiologique] Erreur de conformité : 
            Un isolat d'une entry d'un CR d'examens biologiques doit comporter un élément fils 'specimen', de typeCode 'SPC'. 
        </assert>
            
        <assert test="cda:specimen/cda:specimenRole[@classCode='SPEC']">
            [E_FR-Isolat-microbiologique] Erreur de conformité : 
            Un isolat d'une entry d'un CR d'examens biologiques doit comporter un specimen/specimenRole, de typeCode 'SPEC'. 
        </assert>
        
        <assert test="cda:specimen/cda:specimenRole/cda:specimenPlayingEntity[@classCode='MIC']">
            [E_FR-Isolat-microbiologique] Erreur de conformité : 
            Un isolat d'une entry d'un CR d'examens biologiques doit comporter un specimen/specimenRole/playingEntity de classCode 'MIC'. 
        </assert>
        
        <assert test='cda:specimen/cda:specimenRole/cda:specimenPlayingEntity/cda:code'>
            [E_FR-Isolat-microbiologique] Erreur de conformité : 
            Un isolat d'une entry d'un CR d'examens biologiques doit comporter un specimen/specimenRole/playingEntity/code. 
        </assert>
        
        <assert test="not(cda:performer) or cda:performer[@typeCode='PRF']">
            [E_FR-Isolat-microbiologique] Erreur de conformité :
            Si un isolat d'une entry d'un CR d'examens biologiques spécifie un exécutant, ce doit être un élément fils performer de type 'PRF'. 
        </assert> 
        
    </rule>
 
</pattern>
