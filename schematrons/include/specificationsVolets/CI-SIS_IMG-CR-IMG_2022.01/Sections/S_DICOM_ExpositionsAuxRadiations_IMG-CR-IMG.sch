<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
  S_DICOM_ExpositionsAuxRadiations_IMG-CR-IMG.sh
   Schématron de vérification de la conformité au modèle du CI-SIS de la sous section FR-DICOM-Exposition-aux-radiations(1.2.250.1.213.1.1.2.215) dans le document IMG-CR-IMG qui décrit 
   l'exposition aux radiations du patient.
   
   IMG-CR-IMG : Compte rendu d'imagerie
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
      06/04/2021 : SBM : Création
    29/04/2021 : ANS : Suppression du controle sur la balise title
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_DICOM_ExpositionsAuxRadiations_IMG-CR-IMG">
    <title>CI-SIS IMG-CR-IMG Section FR-DICOM-Exposition-aux-radiations</title>
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.215"]'>
        
        <!-- Vérifier le code de la section 'FR-DICOM-Exposition-aux-radiations' -->
        <assert test="cda:code[@code='73569-6' and @codeSystem='2.16.840.1.113883.6.1']">
            [S_DICOM_ExpositionsAuxRadiations_IMG-CR-IMG] Erreur de conformité : Si elle existe, la sous-section FR-DICOM-Exposition-aux-radiations (1.2.250.1.213.1.1.2.215) doit obligatoirement avoir comme code : @code='73569-6' et @codeSystem='2.16.840.1.113883.6.1'
        </assert>
        
        <!-- Vérifier le texte de la section 'FR-DICOM-Exposition-aux-radiations' -->
        <assert test="cda:text">
            [S_DICOM_ExpositionsAuxRadiations_IMG-CR-IMG] Erreur de conformité : Si elle existe, la sous-section FR-DICOM-Exposition-aux-radiations (1.2.250.1.213.1.1.2.215) doit obligatoirement contenir l'élément text
        </assert>
        
        <!-- Vérifier les contraintes au niveau de l'entrée FR-DICOM-Exposition-patient [0..1]-->
        <assert test="count(.//cda:procedure[cda:templateId/@root='1.2.250.1.213.1.1.3.165'])&lt;=1 and
            .//cda:procedure[cda:templateId/@root='1.2.250.1.213.1.1.3.165']/cda:code[@code='121290' and @codeSystem='1.2.840.10008.2.16.4']">
            [S_DICOM_ExpositionsAuxRadiations_IMG-CR-IMG] Erreur de conformité : Si elle existe, l'entrée FR-DICOM-Exposition-patient (1.2.250.1.213.1.1.3.165) doit avoir obligatoirement le code/@code="121290" [1..1].
        </assert>
        
        <!-- Vérifier les contraintes au niveau de l'entrée FR-DICOM-Observation : grossesse [0..1]-->
        <assert test="not(.//cda:observation[cda:templateId/@root='1.2.250.1.213.1.1.3.150']) or (.//cda:observation[cda:templateId/@root='1.2.250.1.213.1.1.3.150']/cda:code/@code='364320009' and
            .//cda:observation[cda:templateId/@root='1.2.250.1.213.1.1.3.150']/cda:value)">
            [S_DICOM_ExpositionsAuxRadiations_IMG-CR-IMG] Erreur de conformité : Si elle existe, l'entrée FR-DICOM-Observation : grossesse (1.2.250.1.213.1.1.3.150) doit avoir obligatoirement le code/@code="364320009" [1..1].
        </assert>
        
        <!-- Vérifier les contraintes au niveau de l'entrée FR-DICOM-Quantite [0..*] -->
        <assert test="not(.//cda:observation[cda:templateId/@root='1.2.250.1.213.1.1.3.154']) or 
            (.//cda:observation[cda:templateId/@root='1.2.250.1.213.1.1.3.154']
            and .//cda:observation[cda:templateId/@root='1.2.250.1.213.1.1.3.154']/cda:code
            and .//cda:observation[cda:templateId/@root='1.2.250.1.213.1.1.3.154']/cda:value)">
            [S_DICOM_ExpositionsAuxRadiations_IMG-CR-IMG] Erreur de conformité :  Si elle existe, l'entrée FR-DICOM-Quantite doit obligatoirement contenir l'élèment code et value.
        </assert>
        
        <!-- Vérifier les contraintes au niveau de l'entrée FR-DICOM-Administration-produit-de-sante [0..1]-->
        <assert test="not(.//cda:substanceAdministration[cda:templateId/@root='1.2.250.1.213.1.1.3.151']) or (.//cda:substanceAdministration[cda:templateId/@root='1.2.250.1.213.1.1.3.151']/cda:code/@code='440252007' and
            .//cda:substanceAdministration[cda:templateId/@root='1.2.250.1.213.1.1.3.151']/cda:code/@codeSystem='2.16.840.1.113883.6.96')">
            [S_DICOM_ExpositionsAuxRadiations_IMG-CR-IMG] Erreur de conformité : Si elle existe, l'entrée FR-DICOM-Administration-produit-de-sante (2.16.840.1.113883.6.96') pour les produits radiopharmacetiques doit avoir obligatoirement le code/@code="440252007"
            et le code/@codeSystem=".16.840.1.113883.6.96"
        </assert>
    </rule>
    
</pattern>