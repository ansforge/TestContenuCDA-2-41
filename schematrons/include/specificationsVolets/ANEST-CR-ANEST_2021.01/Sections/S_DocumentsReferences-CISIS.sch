<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
   S_DocumentsReferences_ANEST-CR-ANEST.sch
   Schématron de vérification de la conformité au modèle du CI-SIS de la section FR-Documents-references(1.2.250.1.213.1.1.2.55) dans le document ANEST-CR-ANEST
      ...................................................................................................................................................... 
   ANEST-CR-ANEST : Compte rendu d'anesthésie
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    23/04/2021 : SBM : Création
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_DocumentsReferences_ANEST-CR-ANEST">
    <title>CI-SIS ANEST-CR-ANEST Section Documents référencés</title>
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.55"]'>
        <!-- Vérifier le title de la section 'FR-Documents-references' -->
        <assert test='.//cda:title/text()="Documents référencés"'>
            [S_DocumentsReferences-CISIS] Erreur de conformité au modèle ANEST-CR-ANEST : Une section FR-Documents-references (1.2.250.1.213.1.1.2.55) doit obligatoirement
            contenir le title 'Documents référencés'
        </assert>
        
        <!-- Vérifier la cardinalité de l'entrée 'FR-References-externes' [1..*]-->
        <assert test='count(./cda:entry[cda:act/cda:templateId/@root="1.2.250.1.213.1.1.3.35"]) &gt;= 1'>
            [S_DocumentsReferences-CISIS] Erreur de conformité au modèle ANEST-CR-ANEST : Si elle existe, une section FR-Documents-references (1.2.250.1.213.1.1.2.55)
            doit obligatoirement contenir [1..*] entrée FR-References-externes(1.2.250.1.213.1.1.3.35).
        </assert>
        
    </rule>
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.3.35"]'>
        <!-- Vérifier la Valeur nullFlavor du code -->
        <assert test='./cda:code/@nullFlavor="NA"'>
            [S_DocumentsReferences-CISIS] Erreur de conformité au modèle ANEST-CR-ANEST : l'entrée FR-References-externes (1.2.250.1.213.1.1.3.35)
            doit obligatoirement contenir l'élément code dont l'attribut @nullFlavor="NA".
        </assert>
        
        <!-- Vérifier la cardinalité du text [1..1] -->
        <assert test='./cda:text and count(./cda:text)=1'>
            [S_DocumentsReferences-CISIS] Erreur de conformité au modèle ANEST-CR-ANEST : l'entrée FR-References-externes (1.2.250.1.213.1.1.3.35)
            doit obligatoirement contenir l'élément text [1..1].
        </assert>
        
        
        <!-- Vérifier la cardinalité de la référence [1..*] -->
        <assert test='./cda:reference and count(./cda:reference)&gt;=1'>
            [S_DocumentsReferences-CISIS] Erreur de conformité au modèle ANEST-CR-ANEST : l'entrée FR-References-externes (1.2.250.1.213.1.1.3.35)
            doit obligatoirement contenir un ou plusieurs élément(s) reference [1..*].
        </assert>
    </rule>
</pattern>

