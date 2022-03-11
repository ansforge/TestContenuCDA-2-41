<?xml version="1.0" encoding="UTF-8"?>

<!-- S_bilanCancerologie_ANS
    
    Vérification de la conformité de la section FR-Bilan-cancerologie (1.2.250.1.213.1.1.2.59) créée par l'ANS
    
    Historique :
    14/01/2020 : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_bilanCancerologie_ANS">
    <title>Vérification de la conformité de la section FR-Bilan-cancerologie (1.2.250.1.213.1.1.2.59) créée par l'ANS</title>
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.59"]'> 
        
        <!-- Verifier que le templateId est utilisé à bon escient --> 
        <assert test='../cda:section'> 
            [S_bilanCancerologie_ANS.sch] erreur de conformité CI-SIS : Cet élément ne peut être utilisé que comme section. 
        </assert> 
        
        <assert test="count(cda:id)=1">
            [S_bilanCancerologie_ANS.sch] erreur de conformité CI-SIS : Cette section doit contenir un 'id' unique.
        </assert>
        
        <assert test="cda:text">
            [S_bilanCancerologie_ANS.sch] erreur de conformité CI-SIS : Cette section doit contenir un élément 'text'.
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "72135-7"]'> 
            [S_bilanCancerologie_ANS.sch] erreur de conformité CI-SIS : Le code de cette section doit être '72135-7'. 
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_bilanCancerologie_ANS.sch] erreur de conformité CI-SIS : L'attribut 'codeSystem' du 'code' de la section doit être '2.16.840.1.113883.6.1' (LOINC). 
        </assert>
        
        <assert test="//cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.36'">
            [S_bilanCancerologie_ANS.sch] erreur de conformité CI-SIS : Une sous-section de type Plan de soin codé est obligatoire (1.3.6.1.4.1.19376.1.5.3.1.3.36)
        </assert>
        
        <assert test="//cda:templateId/@root='1.3.6.1.4.1.19376.1.7.3.1.1.13.7'">
            [S_bilanCancerologie_ANS.sch] erreur de conformité CI-SIS : Une sous-section de type Résultats d’évènements codé est obligatoire (1.3.6.1.4.1.19376.1.7.3.1.1.13.7)
        </assert>
        
        <assert test="//cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.28'">
            [S_bilanCancerologie_ANS.sch] erreur de conformité CI-SIS : Une sous-section de type Résultats d’examens codé est obligatoire (1.3.6.1.4.1.19376.1.5.3.1.3.28)
        </assert>        
        
    </rule>
    
</pattern>