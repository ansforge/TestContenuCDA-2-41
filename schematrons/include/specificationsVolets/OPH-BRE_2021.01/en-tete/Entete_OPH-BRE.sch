<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    Contrôle la conformité de l'auteur dans l'entête du volet OPH_BRE 

-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="Entete_OPH-BRE">
    <!-- Contrôles spécifiques à l'en tête -->
    <rule context="cda:ClinicalDocument">
        <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.42']"> 
            [OPH-BRE_2021.01] Erreur de conformité : Le templateId "1.2.250.1.213.1.1.1.42" doit être présent.
        </assert>
        <assert test="cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.1.1']"> 
            [OPH-BRE_2021.01] Erreur de conformité : Le templateId "1.3.6.1.4.1.19376.1.9.1.1.1" doit être présent.
        </assert>
        <assert test="./cda:code[@code='78513-9' and @codeSystem='2.16.840.1.113883.6.1']"> 
            [OPH-BRE_2021.01] Erreur de conformité : L'élément "code" doit avoir les attributs @code="78513-9" et @codeSystem="2.16.840.1.113883.6.1". 
        </assert>                        
    </rule>
    <!--     Ophtalmologue, Orthoptiste, Opticien	 -->
    <rule context="cda:ClinicalDocument/cda:author/cda:assignedAuthor">
        <assert test="cda:code[@code='G15_10/SM38' or @code='G15_28' or @code='G15_92'] and cda:code[@codeSystem='1.2.250.1.213.1.1.4.5']">
            [Entete_OPH-BRE_2021.01] L'auteur du document doit avoir un code fixé à une des valeurs suivantes :'G15_10/SM38' ou 'G15_28' ou 'G15_92'
            et un codeSystem fixé à '1.2.250.1.213.1.1.4.5'.
        </assert>
    </rule>
</pattern>