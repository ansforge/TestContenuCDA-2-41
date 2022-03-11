<?xml version="1.0" encoding="UTF-8"?>

<!-- S_Prescriptions_int
     ......................................................................................................................................................
     Vérification de la conformité de la section "FR-Prescriptions" à IHE "Prescription section"
     ......................................................................................................................................................
     Historique :
        - 23/06/2020 : Création
        - 30/11/2020 : Mise à jour
-->

    <pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_prescriptions_int">
        <title> Section IHE "Prescription section"</title>
    
        <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.9.1.2.1']">
            <!-- Test de la présence des templateId relatifs à la section
            <assert test="cda:templateId[@root='2.16.840.1.113883.10.20.1.8']">
                [1] [S_Prescriptions_int.sch] Erreur de conformité au volet IHE Pharm PRE : 
                La section IHE "Prescription section" doit contenir 2 occurences de templateId :
                - Le premier templateId doit avoir un @root="1.3.6.1.4.1.19376.1.9.1.2.1" (Conformité de la section aux spécifications IHE Pharm PRE)
                - Le deuxième templateId doit avoir un @root="2.16.840.1.113883.10.20.1.8"
            </assert> -->
    
            <!-- Test présence obligatoire <id> -->
            <assert test="cda:id">
                [2] [S_Prescriptions_int.sch] Erreur de conformité au volet IHE Pharm PRE : 
                Il faut obligatoirement un élément 'id' pour la section (cardinalité [1..1]).
            </assert>
            
            <!-- Test conformité du <code> -->
            <assert test="cda:code[@code='57828-6'] and count(cda:code) = 1">
                [3] [S_Prescriptions_int.sch] Erreur de conformité au volet IHE Pharm PRE : 
                L'élément code est obligatoire et doit avoir son attribut @code ="57828-6" (cardinalité [1..1])
            </assert>
    
            <!-- Test conformité du <code> -->
            <assert test="cda:code[@codeSystem='2.16.840.1.113883.6.1'] and count(cda:code) = 1">
                [4] [S_Prescriptions_int.sch] Erreur de conformité au volet IHE Pharm PRE : 
                L'élément code est obligatoire et doit avoir son attribut @codeSystem = "2.16.840.1.113883.6.1" (cardinalité [1..1])
            </assert>
    
        
            <!-- Présence obligatoire d'au moins une entrée "Prescription item entry" (et uniquement celle-ci) [1..*] -->
            <assert test="count(//cda:section[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.2.1']]/cda:entry[cda:substanceAdministration/cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.2']])
                = count(//cda:section[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.2.1']]/cda:entry[//cda:templateId[@root]])">
                [5] [S_Prescriptions_int.sch] Erreur de conformité au volet IHE Pharm PRE : 
                La section "Prescription" ne peut contenir qu'une/des entrée(s) "Prescription Item Entry Content Module" (cardinalité [1..*]), 
                dont le 'templateId' doit avoir un attribut @root="1.3.6.1.4.1.19376.1.9.1.3.2" (conformité de l'entrée au format IHE Pharm PRE)
            </assert>
        </rule> 
    </pattern>
