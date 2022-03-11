<?xml version="1.0" encoding="UTF-8"?>

<!--  S_comment_ANS.sch    
    
    Vérification de la conformité de la section FR-Commentaire-Asip (1.2.250.1.213.1.1.2.47) créée par l'ANS
    
    Historique :
    11/10/2016 : NMA : Création  CommentSection20161011.sch
    04/07/17 : NMA : Ajout de la contrainte sur le nombre des templateIds et renommage du schématron
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_comment_ANS">
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.47"]'> 
        
        <!-- Verify that the template id is used on the appropriate type of object --> 
        <assert test='../cda:section'> 
            [S_comment_ANS] Erreur de conformité CI-SIS : Ce composant ne peut être utilisé qu'en tant que section. 
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "48767-8"]'> 
            [S_comment_ANS] Erreur de conformité CI-SIS : Le code de la section doit être 48767-8 
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_comment_ANS] Erreur de conformité CI-SIS : Le code de la section doit être tiré de la terminologie LOINC (2.16.840.1.113883.6.1). 
        </assert> 
        
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.13"]'> 
            <!-- Verify that all required data elements are present -->
            [S_comment_ANS] Erreur de conformité CI-SIS : La section doit contenir des entrées 
            du type Simple Observation Entry  (1.3.6.1.4.1.19376.1.5.3.1.4.13).
        </assert>
        
    </rule> 
</pattern>

