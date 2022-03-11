<?xml version="1.0" encoding="UTF-8"?>

<!-- S_prescriptionDispositifsMedicaux
     ......................................................................................................................................................
     Vérification de la conformité de la section "Prescription-dispositifs-medicaux"
     ......................................................................................................................................................
     Historique :
        - 01/09/2021 : Création
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_prescriptionDispositifsMedicaux">
    <title> Section "prescription Dispositifs Medicaux"</title>

    <rule context="*[cda:templateId/@root = '1.2.250.1.213.1.1.2.222']">

        <!-- Test présence obligatoire <id> -->
        <assert test="cda:id"> [2] [S_prescriptionDispositifsMedicaux.sch] Erreur de conformité : Il
            faut obligatoirement un élément 'id' pour la section (cardinalité [1..1]). </assert>

        <!-- Test conformité du <code> -->
        <assert test="cda:code[@code = '46264-8'] and count(cda:code) = 1"> [3]
            [S_prescriptionDispositifsMedicaux.sch] Erreur de conformité : L'élément code est
            obligatoire et doit avoir son attribut @code ="46264-8" (cardinalité [1..1]) </assert>


        <!-- Présence obligatoire d'au moins une entrée "Dispositif Medical item entry" (et uniquement celle-ci) [1..*] -->
        <assert
            test="
                count(//cda:section[cda:templateId[@root = '1.2.250.1.213.1.1.2.222']]/cda:entry[cda:supply/cda:templateId[@root = '2.16.840.1.113883.10.20.1.34']])
                = count(//cda:section[cda:templateId[@root = '1.2.250.1.213.1.1.2.222']]/cda:entry[//cda:templateId[@root]])"
            > [5] [S_prescriptionDispositifsMedicaux.sch] Erreur de conformité : La section
            "FR-Prescription-dispositifs-medicaux" ne peut contenir qu'une/des entrée(s) "Prescription Item Entry Content
            Module" (cardinalité [1..*]), dont le 'templateId' doit avoir un attribut
            @root="2.16.840.1.113883.10.20.1.34"
        </assert>
    </rule>
</pattern>
