<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    legalAuthenticator_int.sch :
    Contenu :
        Contrôle du legalAuthenticator dans l'en-tête CDA  par rapport au profil IHE_XDS-SD
    Paramètres d'appel :
        Néant
    Historique :
        15/06/2017 : LBE : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="legalAuthenticator_int">
    <rule context="cda:ClinicalDocument/cda:legalAuthenticator/cda:assignedEntity/cda:id">
        <assert test="@root and @extension">
            [legalAuthenticator_int.sch] Erreur de conformité IHE_XDS-SD : L'élément legalAuthenticator/assignedEntity/id doit contenir les attributs @root et @extension
        </assert>
    </rule>
</pattern>   