<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    E_FR-Batterie-examens-de-biologie-medicale.sch :
    
    Vérification de la conformité d'une entrée FR-Batterie-examens-de-biologie-medicale (1.3.6.1.4.1.19376.1.3.1.4)
    
    Historique :
    13/01/2021 : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_FR-Batterie-examens-de-biologie-medicale">
    <p>Vérification de la conformité d'une entrée FR-Batterie-examens-de-biologie-medicale (1.3.6.1.4.1.19376.1.3.1.4)</p>
    <rule context="*[cda:templateId/@root = '1.3.6.1.4.1.19376.1.3.1.4']">
        <assert test="self::cda:organizer and @classCode = 'BATTERY' and @moodCode = 'EVN'"> 
            [E_FR-Batterie-examens-de-biologie-medicale] Erreur de conformité : 
            Une entrée FR-Batterie-examens-de-biologie-medicale ('1.3.6.1.4.1.19376.1.3.1.4') doit avoir un classCode='BATTERY' et un moodCode='EVN'. 
        </assert>
        
        <assert test="./cda:statusCode[@code = 'completed'] or
            ./cda:statusCode[@code = 'active'] or
            ./cda:statusCode[@code = 'aborted']"> 
            [E_FR-Batterie-examens-de-biologie-medicale] Erreur de conformité :
            Une entrée FR-Batterie-examens-de-biologie-medicale ('1.3.6.1.4.1.19376.1.3.1.4') doit avoir un statusCode@code 'completed', 'active' ou 'aborted'. 
        </assert>
    </rule>
</pattern>
