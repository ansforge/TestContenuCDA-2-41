<?xml version="1.0" encoding="UTF-8"?>

<!--  IHE APSR v2.0  "Problem Organizer" (1.3.6.1.4.1.19376.1.8.1.3.6) -->

<!--                  -=<<o#%@O[ E_problemOrganizer_CRGM.sch ]O@%#o>>=-
    
    Teste la conformité de l'Entrée "Liste d'observations / Problem Organizer (1.3.6.1.4.1.19376.1.8.1.3.6)aux spécifications 
    du volet CRGM du CI-SIS de l'ASIP Santé.
    
        
    Historique :
    10/01/2019 : NNA : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_problemOrganizer_CRGM">
    <title>CI-SIS CRGM Entrées Liste d'observations/ Problem Organizer </title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.8.1.3.6"]'>
   
        <let name="count_author" value="count(cda:author)"/>
        
        <!-- Présence obligatoire d'au moins un Auteur  -->
        <assert test="$count_author &gt;=1">
            [E_problemOrganizer_CRGM.sch] Erreur de conformité au Volet CRGM : Au minimum un élément "Author" doit être présent.
        </assert>
                  
    </rule>
    
</pattern>