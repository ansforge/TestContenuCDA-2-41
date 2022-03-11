<?xml version="1.0" encoding="UTF-8"?>

<!-- S_resultatLaboBioSeconde_ANS
    
     Vérification de la conformité de la section FR-Resultats-de-laboratoire-de-biologie-de-seconde-intention (1.2.250.1.213.1.1.2.60) créée par l'ANS
    
    Historique :
    13/01/2020 : NMA : Création
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
    29/04/2021 : ANS : Suppression du control de présence de l'élément id
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_resultatLaboBioSeconde_ANS">
    
    <title>Vérification de la conformité de la section FR-Resultats-de-laboratoire-de-biologie-de-seconde-intention (1.2.250.1.213.1.1.2.60) créée par l'ANS</title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.60"]'>
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_resultatLaboBioSeconde_ANS.sch] Erreur de conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </assert>
        
        <assert test="cda:text">
            [S_resultatLaboBioSeconde_ANS.sch] Erreur de conformité CI-SIS : La section doit contenir un élément 'text'.
        </assert>
        
    </rule>

</pattern>
