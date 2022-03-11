<?xml version="1.0" encoding="UTF-8"?>

<!--  S_BirthOrganizer_OBP.sch 
    
    Teste la conformité de l'entrée FR-Naissance (1.3.6.1.4.1.19376.1.5.3.1.4.13.5.2)
    
    Historique :
    28/10/2013 : Création OBP_BirthOrganizerEntries20131028.sch
    25/10/2017 : Renommage du schématron en S_BirthOrganizer_OBP
    25/01/2022 : Correction des contrôles
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_BirthOrganizer_OBP">  
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13.5.2"]'>  
        <!--  Vérification de la présence des entrées obligatoires        -->
        
        <assert test="cda:component/cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.5']/cda:code[@code='MED-169']">
            [S_BirthOrganizer_OBP] : L'entrée FR-Naissance doit contenir une entrée FR-Observation-sur-la-grossesse "Mode d'accouchement" (MED-169)
        </assert>

        <assert test="cda:component/cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.5']/cda:code[@code='8339-4']">
            [S_BirthOrganizer_OBP] : L'entrée FR-Naissance doit contenir une entrée FR-Observation-sur-la-grossesse "Poids à la naissance" (8339-4)
        </assert>
        <assert test="cda:component/cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.5']/cda:code[@code='OBS_004']">
            [S_BirthOrganizer_OBP] : L'entrée FR-Naissance doit contenir une entrée FR-Observation-sur-la-grossesse "Etat de l'enfant" (OBS_004)
        </assert>
        <assert test="cda:component/cda:observation[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13.5']/cda:code[@code='OBS_005']">
            [S_BirthOrganizer_OBP] : L'entrée FR-Naissance doit contenir une entrée FR-Observation-sur-la-grossesse "Transfert ou mutation" (OBS_005)
        </assert>       
        
    </rule>
</pattern>