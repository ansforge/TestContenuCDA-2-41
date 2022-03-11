<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    componentOf_fr.sch :
    Contenu :
        Contrôle des données de l'élément componentOf dans l'entête selon le volet de strucutration minimale
    Paramètres d'appel :
        Néant
    Historique :
    15/06/2017 : LBE : Création
    05/10/17 : NMA : Correction du message d'erreur sur le code
    
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="componentOf_fr">
    <rule context="cda:componentOf/cda:encompassingEncounter">
        <assert test="count(cda:location) &lt;= 1">
            [componentOf_fr.sch] Erreur de conformité au CI-SIS : L'élément encompassingEncounter/location ne peut être présent qu'une seule fois au maximum [0..1].
        </assert>
    </rule>
    <rule context="cda:componentOf/cda:encompassingEncounter/cda:id">
        <assert test="@root">
            [componentOf_fr.sch] Erreur de conformité au CI-SIS : L'élément encompassingEncounter/id doit contenir un attribut @root
        </assert>         
    </rule>
    <rule context="cda:componentOf/cda:encompassingEncounter/cda:code">
        <assert test="@code and @codeSystem and @displayName">
            [componentOf_fr.sch] Erreur de conformité au CI-SIS : L'élément encompassingEncounter/code doit contenir les attributs @code, @codeSystem et @displayName
        </assert>
    </rule>
    <rule context="cda:componentOf/cda:encompassingEncounter/cda:dischargeDispositionCode">
        <assert test="@code and @displayName">
            [componentOf_fr.sch] Erreur de conformité au CI-SIS : Les attributs @code et @displayName doit être présent lorque l'élément dischargeDispositionCode est présent
        </assert>
        <assert test="not(@codeSystem) or (@codeSystem and @codeSystem='1.2.250.1.213.2.14')">
            [componentOf_fr.sch] Erreur de conformité au CI-SIS : L'attribut codeSystem doit avoir la valeur '1.2.250.1.213.2.14' lorsqu'il est présent
        </assert>
    </rule>
  
</pattern>
