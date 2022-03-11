<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
   S_AllergiesEtIntolerances-CISIS.sch
   Schématron de vérification de la conformité au modèle du CI-SIS de la section FR-Allergies-et-intolerances(1.3.6.1.4.1.19376.1.5.3.1.3.13) dans le document ANEST-CR-CPA 
   Section FR-Allergies-et-intolerances : Allergies médicamenteuses, Intolérances médicamenteuses, Hypersensibilité aux excipients, Allergies de contact , Allergies respiratoires, Allergies topiques, Allergies alimentaires, Intolérances alimentaires.
      ...................................................................................................................................................... 
   ANEST-CR-CPA : Compte rendu de consultation pré-anesthésique
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    04/01/2020 : SBM : Création
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_AllergiesEtIntolerances-CISIS">
    <title>CI-SIS ANEST-CR-CPA Section Allergies et intolérances</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.13"]'>
        <!-- Vérifier le title de la section 'FR-Allergies-et-intolerances' -->
        <assert test='.//cda:title/text()="Allergies, effets indésirables, alertes"'>
            [S_AllergiesEtIntolerances-CISIS] Erreur de conformité au modèle ANEST-CR-CPA : Une section FR-Allergies-et-intolerances (1.3.6.1.4.1.19376.1.5.3.1.3.13) doit obligatoirement
            contenir le title 'Allergies, effets indésirables, alertes'
        </assert>
        
        <!-- Vérifier la cardinalité de l'entrée 'FR-Liste-des-allergies-et-intolerances' -->
        <assert test='count(./cda:entry[cda:act/cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.5.3"]) &gt;= 1'>
            [S_AllergiesEtIntolerances-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une section FR-Allergies-et-intolerances (1.3.6.1.4.1.19376.1.5.3.1.3.13)
            doit obligatoirement contenir [1..*] entrée FR-Liste-des-allergies-et-intolerances(1.3.6.1.4.1.19376.1.5.3.1.4.5.3).
        </assert>
        
    </rule>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.5.3"]'>
        <!-- Vérifier que l'entrée 'FR-Liste-des-allergies-et-intolerances' contient [0..*] entrées FR-Allergie-ou-intolerance "1.3.6.1.4.1.19376.1.5.3.1.4.6" : Allergies médicamenteuses, 
            Intolérances médicamenteuses, Allergie à un agent environnemental (latex, pollen, etc.), Intolérance à un agent environnemental (latex, pollen, etc.), Allergies alimentaires, Intolérances alimentaires -->
        <assert test='count(./cda:entryRelationShip/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.6"])&gt;= 0'>
            [S_AllergiesEtIntolerances-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Une entrée FR-Liste-des-allergies-et-intolerances(1.3.6.1.4.1.19376.1.5.3.1.4.5.3) peut contenir [0..*] entrées Allergie ou intolérance "1.3.6.1.4.1.19376.1.5.3.1.4.6".
        </assert>
    </rule>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.6"]'>
        <!-- Vérifier que l'entrée 'FR-Allergie-ou-intolerance' contient [0..1] Agent responsable de l’allergie -->
        <assert test='count(.//cda:participant) &lt;= 1'>
            [S_AllergiesEtIntolerances-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe une entrée FR-Allergie-ou-intolerance(1.3.6.1.4.1.19376.1.5.3.1.4.6) peut contenir [0..1] Agent responsable de l’allergie.
        </assert>
        
        <!-- Vérifier que l'entrée 'FR-Allergie-ou-intolerance' contient [0..*] entrée FR-Probleme (1.3.6.1.4.1.19376.1.5.3.1.4.5) : réaction observé -->
        <assert test='count(.//cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.5"]) &gt;= 0'>
            [S_AllergiesEtIntolerances-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe une entrée FR-Allergie-ou-intolerance(1.3.6.1.4.1.19376.1.5.3.1.4.6) peut contenir [0..*] entrée FR-Probleme(1.3.6.1.4.1.19376.1.5.3.1.4.5).
        </assert>
        
        <!-- Vérifier que l'entrée 'FR-Allergie-ou-intolerance' contient [0..1] entrée FR-Severite (1.3.6.1.4.1.19376.1.5.3.1.4.1) -->
        <assert test='count(.//cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.1"]) &lt;= 1'>
            [S_AllergiesEtIntolerances-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe une entrée FR-Allergie-ou-intolerance(1.3.6.1.4.1.19376.1.5.3.1.4.6) peut contenir [0..1] entrée FR-Severite(1.3.6.1.4.1.19376.1.5.3.1.4.1).
        </assert>
        
        <!-- Vérifier que l'entrée 'FR-Allergie-ou-intolerance' contient [0..1] entrée FR-Commentaire-ER (1.3.6.1.4.1.19376.1.5.3.1.4.2) -->
        <assert test='count(.//cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.2"]) &lt;= 1'>
            [S_AllergiesEtIntolerances-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe une entrée FR-Allergie-ou-intolerance(1.3.6.1.4.1.19376.1.5.3.1.4.6) peut contenir [0..1] entrée FR-Commentaire-ER(1.3.6.1.4.1.19376.1.5.3.1.4.2).
        </assert>
        
    </rule>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.6"]/cda:participant'>
    <!-- Vérifier que l'entrée 'FR-Allergie-ou-intolerance' contient [1..1] code de l'agent responsable ou bien si l’agent responsable n’est pas trouvé dans les terminologies spécifiées, il est possible d’utiliser du texte libre (le code est mis à nullFlavor="UNK" et le texte libre dans la partie narrative). -->
    <assert test='count(.//cda:code) = 1 or .//cda:code/@nullFlavor="UNK"'>
        [S_AllergiesEtIntolerances-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe une entrée FR-Allergie-ou-intolerance(1.3.6.1.4.1.19376.1.5.3.1.4.6) doit obligatoirement contenir [1..1] code de l'agent responsable de l’allergie ou bien si l’agent responsable n’est pas trouvé dans les terminologies spécifiées, le code est mis à nullFlavor="UNK".
    </assert>
    </rule>
</pattern>

