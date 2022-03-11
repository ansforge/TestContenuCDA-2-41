<?xml version="1.0" encoding="UTF-8"?>

<!--  S_statutDoc_ANS.sch
    
     Vérification de la conformité de la section FR-Statut-du-document (1.2.250.1.213.1.1.2.35) créée par l'ANS
     
    Historique :
    25/08/12 : CRI : Création
    14/01/2013 : CRI : adaptation au value set modifié: 3 statuts: "en cours", "complété", "validé"
    18/01/2013 : CRI : "neutralisation" de l'intitulé des value sets et des codes pour une utilisation transversale de la section
    03/07/17 : NMA : Ajout du test sur le nombre de templateIds et renommage du schématron
    28/07/17 : LBE : Correction de la syntaxe du test pour simple Observation
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_statutDoc_ANS">

    <title>Vérification de la conformité de la section FR-Statut-du-document (1.2.250.1.213.1.1.2.35) créée par l'ANS</title>
        
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.35"]'>
        
        <!-- Verifier que le templateId est utilisé correctement --> 
        <assert test='../cda:section'> 
            [S_statutDoc_ANS] Erreur de conformité CI-SIS : Cet élément ne peut être utilisé que comme section
        </assert> 
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "33557-0"]'> 
            [S_statutDoc_ANS] Erreur de conformité CI-SIS : Le code de cette section doit être '33557-0'       .       
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_statutDoc_ANS] Erreur de conformité CI-SIS :  L'élément 'codeSystem' de cette section doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1)
        </assert> 
            
        <assert test='cda:title'>
            [S_statutDoc_ANS] Erreur de conformité CI-SIS : Cette section doit avoir un titre significatif de son contenu.
        </assert>
        
        <assert test='count(cda:id)=1'>
            [S_statutDoc_ANS] Erreur de conformité CI-SIS : La section doit avoir un identifiant unique permettant de les identifier.
        </assert>
      
        <assert test="cda:entry/cda:observation/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.13']">
            [S_statutDoc_ANS] Erreur de conformité CI-SIS : Cette section comporte obligatoirement une simple Observation
        </assert>
        
    </rule>
    
</pattern>

