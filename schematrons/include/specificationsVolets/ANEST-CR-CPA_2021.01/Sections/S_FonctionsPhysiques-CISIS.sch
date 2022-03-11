<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
   S_FonctionsPhysiques-CISIS.sch
   Schématron de vérification de la conformité au modèle du CI-SIS de la section FR-Fonctions-physiques(1.3.6.1.4.1.19376.1.5.3.1.1.12.2.5) dans le document ANEST-CR-CPA 
   Section FR-Fonctions-physiques : Aide à domicile, Déplacement, Chute, Aide au déplacement, Score GIR, Score de Duke, Support nutritionnel, Malnutrition.
      ...................................................................................................................................................... 
   ANEST-CR-CPA : Compte rendu de consultation pré-anesthésique
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    04/01/2020 : SBM : Création
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_FonctionsPhysiques-CISIS">
    <title>CI-SIS ANEST-CR-CPA Section Fonctions physiques</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.12.2.5"]'>
        
        
        <!-- Vérifier le title de la section 'FR-Fonctions-physiques' -->
        <assert test='.//cda:title/text()="Problèmes physiques fonctionnels et structurels (Autonomie)"'>
            [S_FonctionsPhysiques-CISIS] Erreur de conformité au modèle ANEST-CR-CPA : Une section FR-Fonctions-physiques (1.3.6.1.4.1.19376.1.5.3.1.1.12.2.5) doit obligatoirement contenir le title 'Problèmes physiques fonctionnels et structurels (Autonomie)'
        </assert>
        
        <!-- Vérifier que la section 'FR-Fonctions-physiques' contient [0..*] entrées FR-Evaluation "1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6" : Aide à domicile, Déplacement, Chute, Aide au déplacement, Score GIR, Score de Duke, Support nutritionnel, 
            Malnutrition(Le patient a-t-il perdu du poids involontairement pendant ces derniers 6 mois ?), Malnutrition(Le patient a-t-il mangé moins que d'habitude depuis plus d'une semaine ?) -->
        <assert test='count(./cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6"])&gt;= 0'>
            [S_FonctionsPhysiques-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Une section FR-Fonctions-physiques(1.3.6.1.4.1.19376.1.5.3.1.1.12.2.5) doit obligatoirement contenir [0..9] entrées FR-Evaluation "1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6".
        </assert>
        
        <!-- Vérifier le code de l'entrée  FR-Evaluation "1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6" : Aide à domicile -->
        <assert test='count(.//cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6"]/cda:code[@code="95034-5"])&lt;= 1 '>
            [S_FonctionsPhysiques-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Evaluation "1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6" doit obligatoirement avoir
            un élément code dont l'attribut @code='95034-5'.
        </assert>
        
        <!-- Vérifier le code de l'entrée  FR-Evaluation "1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6" : Déplacement -->
        <assert test='count(.//cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6"]/cda:code[@code="95023-8"]/cda:qualifier/cda:name[@code="MED-596"])&lt;= 1'>
            [S_FonctionsPhysiques-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Evaluation "1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6" doit obligatoirement avoir
            un élément code dont l'attribut @code='95023-8' et en dessous élément qualifier/name dont l'attribut @code='MED-596'.
        </assert>
        
        <!-- Vérifier le code de l'entrée  FR-Evaluation "1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6" : Chute -->
        <assert test='count(.//cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6"]/cda:code[@code="95023-8"]/cda:qualifier/cda:name[@code="MED-597"])&lt;= 1'>
            [S_FonctionsPhysiques-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Evaluation "1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6" doit obligatoirement avoir
            un élément code dont l'attribut @code='95023-8' et en dessous élément qualifier/name dont l'attribut @code='MED-597'.
        </assert>
        
        <!-- Vérifier le code de l'entrée  FR-Evaluation "1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6" : Aide au déplacement -->
        <assert test='count(.//cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6"]/cda:code[@code="95023-8"]/cda:qualifier/cda:name[@code="MED-598"])&lt;= 1'>
            [S_FonctionsPhysiques-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Evaluation "1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6" doit obligatoirement avoir
            un élément code dont l'attribut @code='95023-8' et en dessous élément qualifier/name dont l'attribut @code='MED-598'.
        </assert>
        
        <!-- Vérifier le code de l'entrée  FR-Evaluation "1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6" : Score GIR -->
        <assert test='count(.//cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6"]/cda:code[@code="10210-3"]/cda:qualifier/cda:name[@code="MED-346"])&lt;= 1'>
            [S_FonctionsPhysiques-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Evaluation "1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6" doit obligatoirement avoir
            un élément code dont l'attribut @code='10210-3'et en dessous élément qualifier/name dont l'attribut @code='MED-346'.
        </assert>
        
        <!-- Vérifier le code de l'entrée  FR-Evaluation "1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6" : Score de Duke -->
        <assert test='count(.//cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6"]/cda:code[@code="10210-3"]/cda:qualifier/cda:name[@code="MED-633"])&lt;= 1'>
            [S_FonctionsPhysiques-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Evaluation "1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6" doit obligatoirement avoir
            un élément code dont l'attribut @code='10210-3' et en dessous élément qualifier/name dont l'attribut @code='MED-633'.
        </assert>
        
        <!-- Vérifier le code de l'entrée  FR-Evaluation "1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6" : Support nutritionnel-->
        <assert test='count(.//cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6"]/cda:code[@code="75305-3"]/cda:qualifier/cda:name[@code="MED-599"])&lt;= 1'>
            [S_FonctionsPhysiques-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Evaluation "1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6" doit obligatoirement avoir
            un élément code dont l'attribut @code='75305-3' et en dessous élément qualifier/name dont l'attribut @code='MED-599'.
        </assert>
        
        <!-- Vérifier le code de l'entrée  FR-Evaluation "1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6" : Malnutrition(Le patient a-t-il perdu du poids involontairement pendant ces derniers 6 mois ?) -->
        <assert test='count(.//cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6"]/cda:code[@code="75305-3"]/cda:qualifier/cda:name[@code="MED-650"])&lt;= 1'>
            [S_FonctionsPhysiques-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Evaluation "1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6" doit obligatoirement avoir
            un élément code dont l'attribut @code='75305-3' et en dessous élément qualifier/name dont l'attribut @code='MED-650'.
        </assert>
        
        <!-- Vérifier le code de l'entrée  FR-Evaluation "1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6" : Malnutrition(Le patient a-t-il mangé moins que d'habitude depuis plus d'une semaine ?)-->
        <assert test='count(.//cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6"]/cda:code[@code="75305-3"]/cda:qualifier/cda:name[@code="MED-651"])&lt;= 1'>
            [S_FonctionsPhysiques-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Evaluation "1.3.6.1.4.1.19376.1.5.3.1.1.12.3.6" doit obligatoirement avoir
            un élément code dont l'attribut @code='75305-3' et en dessous élément qualifier/name dont l'attribut @code='MED-651'.
        </assert>
        
    </rule>
</pattern>

