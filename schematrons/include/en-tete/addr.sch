<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    addr.sch :
    Contenu :
        Règles de contrôle d'une adresse géographique CDAr2 (type de données AD) 
        Vérification de la conformité au CI-SIS d'un élément addr (de type AD) du standard CDAr2 :
        L'élément doit comporter au moins un élément fils (composant d'adresse), et peut 
        avoir un attribut optionnel "use".
        Alternativement, si l'attribut nullFlavor est présent, il doit avoir l'une des valeurs admises par le CI-SIS. 
        A partir de CI-SIS 1.3 : Une adresse est soit structurée en composants élémentaires, soit sous la forme de lignes d'adresse
    Paramètres d'appel :
        néant
    Historique :
        27/05/11 : FMY ASIP/PRAS : Création
        28/07/11 : FMY ASIP/PRAS : Complément du texte de l'erreur : "est vide [et sans nullFlavor]
        10/08/12 : CI-SIS 1.3 ==> addr composée uniquement de lignes d'adresse <streetAddressLine> ou bien de composant élémentaires
        excluant l'élément <streetAddressLine>
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="addr">
    <rule context="cda:addr">
        <let name="nba" value="count(@*)"/>
        <let name="nbch" value="count(*)"/>
        <let name="val" value="@*"/>
        <assert test="(
            ($nba = 0 and $nbch &gt; 0) or
            ($nba and name(@*) = 'use' and $nbch &gt; 0) or 
            ($nba = 1 and name(@*) = 'nullFlavor' and $nbch = 0 and
            ($val = 'UNK' or $val = 'NASK' or $val = 'ASKU' or $val = 'NAV' or $val = 'MSK')) 
            )">
            [addr.sch] Erreur de conformité CI-SIS : <name/> ne contient pas un attribut autorisé pour une adresse, 
            ou est vide et sans nullFlavor, ou contient une valeur de nullFlavor non admise.
        </assert>
        <assert test="$nbch = 0 or
                        (cda:streetAddressLine and not(cda:postalCode) and not(cda:city) and not(cda:country) and not(cda:state)
                        and not(cda:houseNumber) and not(cda:streetName)and not(cda:additionalLocator) and not(cda:unitID)
                        and not(cda:postBox) and not(cda:precinct)) or
                        (not(cda:streetAddressLine))
                        ">
            [addr.sch] Erreur de conformité CI-SIS : <name/> doit être structuré : 
            - soit sous la formes de lignes d'adresse (streetAddressLine)
            - soit sous la forme de composants élémentaires d'adresse
        </assert>
    </rule>
</pattern>