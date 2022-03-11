<?xml version="1.0" encoding="UTF-8"?>

<!-- E_produitDeSantePrescrit_fr
     ......................................................................................................................................................
     Vérification de la conformité de l'entrée FR-Produit-de-sante-prescrit aux spécifications du CI-SIS.
     ......................................................................................................................................................
     Historique :
     - 09/06/2020 : Création
     - 30/11/2020 : Finalisation
-->

    <pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_produitDeSantePrescrit_fr">
        <title>CI-SIS Entrée "FR-Produit-de-sante-prescrit"</title>
    
        <rule context="//cda:entry/cda:substanceAdministration[cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.2']]/cda:consumable/cda:manufacturedProduct/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.2']">
            
            <!-- Test des templateId pour l'entrée "FR-Produit-de-sante-prescrit" -->
            <assert test="//cda:templateId[@root='1.2.250.1.213.1.1.3.84']">
                [1] [E_ProduitDeSantePrescrit_fr.sch] Erreur de conformité CI-SIS : 
                L'entrée "FR-Produit-de-sante-prescrit" doit avoir un troisième 'templateId' dont l'attribut @root="1.2.250.1.213.1.1.3.84".
            </assert>
        </rule>       
    </pattern>
