<?xml version="1.0" encoding="UTF-8"?>

<!--  IHE PCC v3.0  Section: 1.2.250.1.213.1.1.2.57 -->

<!--                  -=<<o#%@O[ S_antecedents_D2LM.sch ]O@%#o>>=-
    
    Teste la conformité de la sur-section "Antecedents" (1.2.250.1.213.1.1.2.57)
    aux spécifications du volet D2LM du CI-SIS de l'ASIP Santé sur le contenu de
    la section.    
    
    Historique :
    23/10/17 : NMA : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_microscopicObservation_CRGM">
    <title>CI-SIS D2LM Section Antécédents</title>
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.57"]'>
        <!-- Présence obligatoire de la section History of Past Illness -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.3.8"]'>
            [S_antecedents_D2LM.sch] Erreur de Conformité volet D2LM: La  section 'History of Past Illness' est obligatoire dans la sur-section Antécédents.
        </assert>  
        <assert test='.//cda:code[@code = "11349-8"]'>
            [S_antecedents_D2LM.sch] Erreur de Conformité volet D2LM: Le code de la section 'Antecedents' doit être "11349-8"
        </assert>  
        <assert test='.//cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_antecedents_D2LM.sch] Erreur de Conformité volet D2LM: Le code de la section 'Antecedents' doit faire partie de la nomenclature LOINC
        </assert>  
        
    </rule>
    
</pattern>