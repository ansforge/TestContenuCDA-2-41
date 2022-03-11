<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
   S_HabitusModeDeVie-CISIS.sch
   Schématron de vérification de la conformité au modèle du CI-SIS de la section FR-Habitus-mode-de-vie(1.3.6.1.4.1.19376.1.5.3.1.3.16.1) dans le document ANEST-CR-CPA 
   Section FR-Habitus-mode-de-vie : Risques sociaux, Risques professionnels - Exposition à des produits toxiques, Risques environnementaux,
   Activité professionnelle, Activité sportive, Sédentarité, Tabac, Alcool, Drogues, Voyages récents, Faits marquants.
      ...................................................................................................................................................... 
   ANEST-CR-CPA : Compte rendu de consultation pré-anesthésique
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    04/01/2020 : SBM : Création
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_HabitusModeDeVie-CISIS">
    <title>CI-SIS ANEST-CR-CPA Section Habitus mode de vie </title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.16.1"]'>
        
        
        <!-- Vérifier le title de la section 'FR-Habitus-mode-de-vie' -->
        <assert test='.//cda:title/text()="Facteurs de risques, Habitus, Mode de vie"'>
            [S_HabitusModeDeVie-CISIS] Erreur de conformité au modèle ANEST-CR-CPA : Une section FR-Habitus-mode-de-vie (1.3.6.1.4.1.19376.1.5.3.1.3.16.1) doit obligatoirement contenir le title 'Facteurs de risques, Habitus, Mode de vie'
        </assert>
        
        <!-- Vérifier que la section 'FR-Habitus-mode-de-vie' contient [0..*] entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" : Risques sociaux, Risques professionnels - Exposition à des produits toxiques, Risques environnementaux,
   Activité professionnelle, Activité sportive, Sédentarité, Tabac, Alcool, Drogues, Voyages récents, Faits marquants -->
        <assert test='count(./cda:entry/cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13.4"])&gt;= 0'>
            [S_HabitusModeDeVie-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Une section FR-Habitus-mode-de-vie (1.3.6.1.4.1.19376.1.5.3.1.3.16.1) doit obligatoirement contenir [0..11] entrées FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4"
        </assert>
        
        <!-- Vérifier le code de l'entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" : Risques sociaux -->
        <assert test='count(.//cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13.4"]/cda:code[@code="11345-6"]/cda:qualifier/cda:name[@code="GEN-232"])&lt;= 1'>
            [S_HabitusModeDeVie-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" doit obligatoirement avoir
            un élément code dont l'attribut @code='11345-6' et en dessous élément qualifier/name dont l'attribut @code='GEN-232'.
        </assert>
        
        <!-- Vérifier le code de l'entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" : Risques professionnels - Exposition à des produits toxiques -->
        <assert test='count(.//cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13.4"]/cda:code[@code="92944-8"])&lt;= 1'>
            [S_HabitusModeDeVie-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" doit obligatoirement avoir
            un élément code dont l'attribut @code='92944-8'.
        </assert>
        
        <!-- Vérifier le code de l'entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" : Risques environnementaux -->
        <assert test='count(.//cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13.4"]/cda:code[@code="11345-6"]/cda:qualifier/cda:name[@code="GEN-207"])&lt;= 1'>
            [S_HabitusModeDeVie-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" doit obligatoirement avoir
            un élément code dont l'attribut @code='11345-6' et en dessous élément qualifier/name dont l'attribut @code='GEN-207'.
        </assert>
        
        <!-- Vérifier le code de l'entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" : Activité professionnelle -->
        <assert test='count(.//cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13.4"]/cda:code[@code="11345-6"]/cda:qualifier/cda:name[@code="ORG-075"])&lt;= 1'>
            [S_HabitusModeDeVie-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" doit obligatoirement avoir
            un élément code dont l'attribut @code='11345-6' et en dessous élément qualifier/name dont l'attribut @code='ORG-075'.
        </assert>
        
        <!-- Vérifier le code de l'entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" : Activité sportive -->
        <assert test='count(.//cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13.4"]/cda:code[@code="73985-4"])&lt;= 1'>
            [S_HabitusModeDeVie-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" doit obligatoirement avoir
            un élément code dont l'attribut @code='73985-4'.
        </assert>
        
        <!-- Vérifier le code de l'entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" : Sédentarité -->
        <assert test='count(.//cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13.4"]/cda:code[@code="11345-6"]/cda:qualifier/cda:name[@code="GEN-208"])&lt;= 1'>
            [S_HabitusModeDeVie-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" doit obligatoirement avoir
            un élément code dont l'attribut @code='11345-6' et en dessous élément qualifier/name dont l'attribut @code='GEN-208'.
        </assert>
        
        <!-- Vérifier le code de l'entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" : Tabac-->
        <assert test='count(.//cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13.4"]/cda:code[@code="74011-8"])&lt;= 1'>
            [S_HabitusModeDeVie-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" doit obligatoirement avoir
            un élément code dont l'attribut @code='74011-8'.
        </assert>
        
        <!-- Vérifier le code de l'entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" : Alcool-->
        <assert test='count(.//cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13.4"]/cda:code[@code="74013-4"])&lt;= 1'>
            [S_HabitusModeDeVie-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" doit obligatoirement avoir
            un élément code dont l'attribut @code='74013-4'.
        </assert>
        
        <!-- Vérifier le code de l'entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" : Drogues-->
        <assert test='count(.//cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13.4"]/cda:code[@code="42831-8"])&lt;= 1'>
            [S_HabitusModeDeVie-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" doit obligatoirement avoir
            un élément code dont l'attribut @code='42831-8'.
        </assert>
        
        <!-- Vérifier le code de l'entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" : Voyages récents-->
        <assert test='count(.//cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13.4"]/cda:code[@code="11345-6"]/cda:qualifier/cda:name[@code="GEN-050"])&lt;= 1'>
            [S_HabitusModeDeVie-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" doit obligatoirement avoir
            un élément code dont l'attribut @code='11345-6' et en dessous élément qualifier/name dont l'attribut @code='GEN-050'.
        </assert>
        
        <!-- Vérifier le code de l'entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" :  Faits marquants -->
        <assert test='count(.//cda:observation[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13.4"]/cda:code[@code="11345-6"]/cda:qualifier/cda:name[@code="GEN-231"])&lt;= 1'>
            [S_HabitusModeDeVie-CISIS.sch] Erreur de conformité au modèle ANEST-CR-CPA : Si elle existe, une entrée FR-Habitus-Mode-de-vie "1.3.6.1.4.1.19376.1.5.3.1.4.13.4" doit obligatoirement avoir
            un élément code dont l'attribut @code='11345-6' et en dessous élément qualifier/name dont l'attribut @code='GEN-231'.
        </assert>
         
    </rule>
</pattern>

