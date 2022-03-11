<?xml version="1.0" encoding="UTF-8"?>

<!-- S_anamnese_ANS.sch
    
    Vérification de la conformité de la section FR-Anamnese (1.2.250.1.213.1.1.2.69) créée par l'ANS
    
    Historique :
    29/11/2019 : Création
    19/12/2019 : Corrections
    30/01/2020 : Suppression du test sur le nombre de templateId
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_anamnese_ANS">
    <title>Vérification de la conformité de la section FR-Anamnese (1.2.250.1.213.1.1.2.69) créée par l'ANS</title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.69"]'>
        <!-- Vérifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_anamnese_ANS.sch] Erreur de conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </assert>
        <assert test="count(cda:id)=1">
            [S_anamnese_ANS.sch] Erreur de conformité CI-SIS : La section doit contenir un id (cardinalité [1..1])
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "34117-2"]'> 
            [S_anamnese_ANS.sch] Erreur de conformité CI-SIS : Le code de la section 'ANAMNESE' doit être '34117-2' 
        </assert> 
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_anamnese_ANS.sch] Erreur de conformité CI-SIS : L'attribut 'codeSystem' de la section a pour valeur '2.16.840.1.113883.6.1' (LOINC). 
        </assert>
        <!-- Vérification de la présence de l'élément text -->
        <assert test="(not(cda:component/cda:section) and cda:text) or (count(cda:component/cda:section)&lt;=5 and not(cda:text) and (cda:component/cda:section))
            and (cda:component/cda:section/cda:templateId[
            @root = '1.3.6.1.4.1.19376.1.5.3.1.3.6' or
            @root = '1.3.6.1.4.1.19376.1.5.3.1.3.8' or
            @root = '1.3.6.1.4.1.19376.1.5.3.1.3.12' or
            @root = '1.3.6.1.4.1.19376.1.5.3.1.3.13' or
            @root = '1.3.6.1.4.1.19376.1.5.3.1.3.15'])">
            [S_anamnese_ANS.sch] Erreur de conformité CI-SIS : 
            Si aucune des 5 sous-sections optionnelles n’est présente : l’élément 'text' est obligatoire.
            Si les 5 sous-sections sont présentes : l’élément 'text' est interdit. En effet, chacune est porteuse de son propre 'text' en plus de ses données structurées.            
        </assert>
        
    </rule>
    
</pattern>