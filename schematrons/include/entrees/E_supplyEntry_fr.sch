<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=
    E_supplyEntry_fr 
    Vérifie la conformité par rapport au profil Modèle de Contenus CDA de l'entrée supplys Entry (1.3.6.1.4.1.19376.1.5.3.1.4.7.3
    Vérification du compte : 
    id
    auteurs
    performer
    quantity
    effectiveTime
    entryRelationShip instructions dispensateur (1.3.6.1.4.1.19376.1.5.3.1.4.3.1)
    26/06/2017 : LBE : Création
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_supplyEntry_fr">
    <title>CI-SIS Supply entry</title>
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.3']">
        
       <let name="count_author" value="count(cda:author)"/>
       <let name="count_performer" value="count(cda:performer)"/>
       <let name="count_id" value="count(cda:id)"/>
       <let name="count_quantity" value="count(cda:quantity)"/>
        <let name="count_effectiveTime" value="count(cda:effectiveTime)"/>
        <let name="count_entryRelationShip" value="count(cda:entryRelationship[@typeCode='SUBJ']/cda:act)"/>
       
       
       <assert test="$count_id=1">
           [E_supplyEntry_fr.sch] Errreur de conformité CI-SIS: L'élément supply doit contenir un élément id (cardinalité [1..1])
       </assert>
       
       <assert test="$count_effectiveTime &lt;=1">
           [E_supplyEntry_fr.sch] Errreur de conformité CI-SIS: L'élément supply ne doit contenir qu'un effectiveTime au maximum (cardinalité [0..1])
       </assert>
        <assert test="$count_quantity&lt;=1">
            [E_supplyEntry_fr.sch] Errreur de conformité CI-SIS: L'élément supply ne doit contenir qu'un élément 'quantity' au maximum (cardinalité [0..1])
        </assert>
        <assert test="$count_author&lt;=1">
            [E_supplyEntry_fr.sch] Errreur de conformité CI-SIS: L'élément supply ne doit contenir qu'un élément 'author' au maximum (cardinalité [0..1])
        </assert>
        <assert test="$count_performer&lt;=1">
            [E_supplyEntry_fr.sch] Errreur de conformité CI-SIS: L'élément supply ne doit contenir qu'un élément 'performer' au maximum (cardinalité [0..1])
        </assert>
        <assert test="$count_entryRelationShip&lt;=1">
            [E_supplyEntry_fr.sch] Errreur de conformité CI-SIS: L'élément supply ne doit contenir qu'un élément 'entryRelationShip' au maximum (cardinalité [0..1])
        </assert>
        
        <assert test="not(cda:entryRelationship) or (cda:entryRelationship and cda:entryRelationship[@typeCode='SUBJ']/cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.3.1'])">
            [E_supplyEntry_fr.sch] Errreur de conformité CI-SIS: Si l'élément supply conttient un entryRelationship, il doit avoir la forme suivante : entryRelationship[@typeCode='SUBJ']/act/templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.3.1'])
        </assert>
       
       
    </rule>
</pattern>
