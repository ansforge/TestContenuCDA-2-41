<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    Contrôle la conformité de l'auteur dans l'entête du volet OPH_BRE 
    Ophtalmologue
    Orthoptiste
    Opticien	
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="author_OPH">
    <rule context="cda:ClinicalDocument/cda:author/cda:assignedAuthor">
        <assert test="cda:code[@code='G15_10/SM38' or @code='G15_28' or @code='G15_92'] and cda:code[@codeSystem='1.2.250.1.213.1.1.4.5']">
            [author_OPH] L'auteur du document doit avoir un code fixé à une des valeurs suivantes :'G15_10/SM38' ou 'G15_28' ou 'G15_92'
            et un codeSystem fixé à '1.2.250.1.213.1.1.4.5'.
        </assert>
    </rule>
</pattern>