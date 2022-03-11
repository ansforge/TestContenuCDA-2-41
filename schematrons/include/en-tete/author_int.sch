<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    author_int.sch :
    Contenu :
        Contrôle la conformité de l'auteur dans l'entête par rapport au profil international
        Paramètres d'appel :
        Néant
    Historique :
    12/06/2017 : LBE : Création
    26/07/2017 : NMA : Correction de l'assert sur la repreentedOrganization
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="author_int">
    <rule context="cda:ClinicalDocument/cda:author">
        <let name="count_name_patient" value="count(cda:time)"/>
        <let name="count_name_guardianPerson" value="count(cda:patient/cda:guardian/cda:guardianPerson/cda:name)"/>
        <assert test="cda:assignedAuthor/cda:id[@root] and cda:assignedAuthor/cda:id[@extension]">
            [author_int.sch] Erreur de conformité XDS-SD : L'élément author/assignedAuthor/id doit contenir les attributs @root et @extension
        </assert>
        <assert test="(cda:assignedAuthor/cda:representedOrganization/cda:id[@root] and cda:assignedAuthor/cda:representedOrganization/cda:id[@extension]) or not(cda:assignedAuthor/cda:representedOrganization)">
            [author_int.sch] Erreur de conformité XDS-SD : L'élément author/assignedAuthor/representedOrganization/id doit contenir les attributs @root et @extension
        </assert>
    </rule>
</pattern>