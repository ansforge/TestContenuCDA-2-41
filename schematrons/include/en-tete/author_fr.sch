<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    author_fr.sch :
    Contenu :
       Contrôle la conformité de l'auteur dans l'entête par rapport aux spécificités françaises
    Paramètres d'appel :
        Néant
    Historique :
   12/06/2017 : LBE : Création
   29/04/2019 : NMA : Autorisation du nullFlavor pour l'élément time
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="author_fr">
    <rule context="cda:ClinicalDocument/cda:author">
       <assert test="cda:time[@value] or cda:time[@nullFlavor]">
           [author_fr] L'élément "time" dans "author" doit être présent et renseigné.
       </assert>
    </rule>
</pattern>