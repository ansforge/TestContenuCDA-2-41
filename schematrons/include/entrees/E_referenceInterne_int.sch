<?xml version="1.0" encoding="UTF-8"?>

<!-- E_referenceInterne_int
     ......................................................................................................................................................
     Vérification de la conformité de l'entrée FR-Reference-interne (IHE-PCC - Internal-Reference - 1.3.6.1.4.1.19376.1.5.3.1.4.4.1) à IHE.
     ......................................................................................................................................................
     Historique :
     - 09/06/2020 : Création
     - 30/11/2020 : Finalisation
-->
    <pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_referenceInterne_int">
        <title>Entrée FR-Reference-interne (IHE-PCC - Internal-Reference - 1.3.6.1.4.1.19376.1.5.3.1.4.4.1)</title>    
        
        <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.4.1"]'>
            <!-- Test présence et nombre max de l'élément 'id' -->
            <assert test="count(cda:id)=1">
                [2] [E_reference-interne_int.sch] Erreur de conformité IHE PCC : 
                L'entrée FR-Reference-interne doit comporter un élément 'id'.
            </assert>
            
            <!-- Test présence et format de l'élément 'code' -->
            <assert test="(count(cda:code[@nullFlavor='NA'])=1) or (count(cda:code[@code and @codeSystem])=1)">
                [3][E_reference-interne_int.sch] Erreur de conformité IHE PCC : 
                L'entrée FR-Reference-interne doit comporter un 'code' identique à l’élément référencé. Si l’élément référencé n’est pas codé, alors le 'code' doit être @nullFlavor="NA".
            </assert>
        </rule>
    </pattern>
