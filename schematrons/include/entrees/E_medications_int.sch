<?xml version="1.0" encoding="UTF-8"?>

<!-- E_medications_int
     ......................................................................................................................................................
     Vérification de la conformité de l'entrée FR-Traitement (1.3.6.1.4.1.19376.1.5.3.1.4.7) à IHE PCC.
     ......................................................................................................................................................
     Historique :
     02/08/2011 : Création
     26/06/2017 : Modification et MaJ par rapport à IHE PCC
     01/03/2018 : Acceptation du nullFlavor dans le nullFlavor[2]
     02/03/2018 : Acceptation d'autres nullFlavors que le UNK dans le nullFlavor[1]
     15/04/2020 : Ajout de la vérification de la présence des éléments <text><reference>
     01/02/2021 : Autoriser plusieurs OIDs modalités d'administration (pour combiner "doses progressives" et "doses combinées" par exemple).
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_medications_int">
    <title>IHE PCC v3.0 Medications</title>
       
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.7"]'>
        <assert test="@classCode='SBADM' and (@moodCode='INT' or @moodCode='EVN')">
            [E_medications_int.sch] Erreur de conformité PCC : L'élément subastanceAdministration doit avoit un attribut @classCode fixé à 'SBADM' et un attribut @moodCode dont la valeur 
            est soit 'INT' ou 'EVN'
        </assert>
        <!-- Conformité template CCD -->
        
        <assert test='cda:templateId[@root = "2.16.840.1.113883.10.20.1.24"]'>
           [E_medications_int.sch] Erreur de conformité PCC : L'entrée 'Medications' doit comporter un templateId "2.16.840.1.113883.10.20.1.24" ('CCD Medication activity').</assert>
        
        <assert test='count(cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.7.1"] | 
            cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.8"] |
            cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.9"] |
            cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.10"] |
            cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.11"])  > 0'>
            
            [E_medications_int.sch] Erreur de conformité PCC : L'entrée 'Medications' doit comporter au minimum l'un des templateId suivants : 
            normal dosing (1.3.6.1.4.1.19376.1.5.3.1.4.7.1), tapered dosing (1.3.6.1.4.1.19376.1.5.3.1.4.8), 
            split dosing (1.3.6.1.4.1.19376.1.5.3.1.4.9), conditional dosing (1.3.6.1.4.1.19376.1.5.3.1.4.10), 
            combination dosing (1.3.6.1.4.1.19376.1.5.3.1.4.11).</assert>
        
        <assert test='not(cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.7.1"]) or 
            count(.//cda:substanceAdministration) = 0'>
            [E_medications_int.sch] Erreur de conformité PCC :  L'utilisation du template normal dosing (1.3.6.1.4.1.19376.1.5.3.1.4.7.1) 
            dans une entrée 'Medications' implique que l'élément 'substanceAdministration' ne comporte pas d'éléments 
            'substanceAdministration' subordonné.</assert>
        
        <assert test='count(cda:id) = 1'>
            [E_medications_int.sch] Erreur de conformité PCC : un élément 'substanceAdministration' doit avoir un identifiant unique. Si l'éditeur de
            la source (LPS, SIH,...) n'a pas prévu celle-ci, on pourra lui substituer un GUID, utilisé pour l'attribut 'root',
            l'attribut 'extension' pouvant alors être omis.
            Note: même si HL7 admet qu'un élément puisse avoir plusieurs identifiants, cette entrée n'en utilisera qu'un, et un seul.</assert>
        
        <assert test='count(cda:text/cda:reference) = 1'>
            [E_medications_int.sch] Erreur de conformité PCC : un élément 'substanceAdministration' doit avoir un élément 'text' unique contenant un élément 'reference'. </assert>
        
        <assert test='cda:statusCode[@code = "completed"]'>
            [E_medications_int.sch] Erreur de conformité PCC : l'élément 'statusCode' de tout élément 'substanceAdministration' d'une entrée 'Medications' 
            est obligatoirement fixé à la valeur 'completed': soit l'acte a été réalisé, soit la prescription a été faite.</assert>
        
        <assert test='cda:consumable/cda:manufacturedProduct/cda:templateId[@root="1.3.6.1.4.1.19376.1.5.3.1.4.7.2"]'>
            [medications] L'élément 'consumable' doit obligatoirement être présent dans une entrée 'Medications'.
            Il comportera une entrée 'manufacturedProduct' se conformant au template 'Product Entry' (1.3.6.1.4.1.19376.1.5.3.1.4.7.2).</assert>           
              
        <assert test='not(cda:effectiveTime[1]) or (cda:effectiveTime[1] and cda:effectiveTime[1][@xsi:type="IVL_TS"]  and
            ((cda:effectiveTime[1]/cda:low and cda:effectiveTime[1]/cda:high)) or cda:effectiveTime[1]/cda:width)'>
            [E_medications_int.sch] Erreur de conformité PCC : La première occurence de l'élément 'effectiveTime' doit être 
            un intervalle de temps s'il est présent, il sera spécifié comme tel (@xsi:type="IVL_TS").
            Les attributs 'low' et 'high' de cet élément représentent respectivement le début et la fin du tratement prescrit.
            Dans le cas spécifique où seule la durée du médicament est connue, le "low" et le "high" seront remplacés par l'élément "width"</assert>        
        
        <assert test='not(cda:effectiveTime[2]) or (cda:effectiveTime[2] and cda:effectiveTime[2][@operator="A" or @nullFlavor])'>
            [E_medications_int.sch] Erreur de conformité PCC : La fréquence d'administration est requise si elle est connue. 
            Celle-ci sera un élément effectiveTime avec un attribut 'operator' égal à 'A'.
        </assert>
       
    </rule>
</pattern>