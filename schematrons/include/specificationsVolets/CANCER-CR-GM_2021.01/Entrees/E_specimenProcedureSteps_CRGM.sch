<?xml version="1.0" encoding="UTF-8"?>

<!--  IHE APSR v2.0  "Specimen Procedure Steps" (1.3.6.1.4.1.19376.1.3.10.4.1) -->

<!--                  -=<<o#%@O[ E_specimenProcedureSteps_CRGM.sch ]O@%#o>>=-
    
    Teste la conformité de l'Entrée "Prélèvement / Specimen Procedure Steps (1.3.6.1.4.1.19376.1.3.10.4.1)aux spécifications 
    du volet CRGM du CI-SIS de l'ASIP Santé.
    
        
    Historique :
    10/01/2019 : NNA : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_specimenProcedureSteps_CRGM">
    <title>CI-SIS CRGM Prélèvement/ Specimen Procedure Steps </title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.3.10.4.1"]'>
        
        <let name="count_author" value="count(cda:author)"/>
        <let name="count_prelev" value="count(cda:performer)"/>
        <let name="count_specimen" value="count(cda:specimen)"/>
        
        
        <!-- Présence obligatoire d'au moins un Auteur  -->
        <assert test="$count_author &gt;=1">
            [E_specimenProcedureSteps_CRGM.sch] Erreur de conformité au Volet CRGM: Au minimum un élément "Author" doit être présent.
        </assert>
        
        
        <!-- Présence obligatoire d'un prélèveur  -->
        <assert test="$count_prelev = 1">
            [E_specimenProcedureSteps_CRGM.sch] Erreur de conformité au Volet CRGM: Un prélèveur est requis pour cette entrée.
        </assert>
        
        <!-- Présence obligatoire d'un élément Specimen - pour la référence du prélèvement  -->
        <assert test="$count_specimen =1">
            [E_specimenProcedureSteps_CRGM.sch] Erreur de conformité au Volet CRGM: L'élément "specimen" est requis pour cette entrée.
        </assert> 
        
        <!-- Présence obligatoire d'une Sous Entrée Specimen Received  -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.3.1.3"]'>
            [S_specimenProcedureSteps_CRGM.sch] Erreur de Conformité volet CRGM: L'Entrée Specimen Reveived (1.3.6.1.4.1.19376.1.3.1.3) est requise.
        </assert> 
    </rule>
    
</pattern>