<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    telecom.sch :
    Contenu :
        Règles de contrôle d'une adresse de télécommunication CDAr2 (type de données TEL) 
    Paramètres d'appel :
        néant
    Historique :
        27/05/11 : FMY ASIP/PRAS : Création
        28/07/11 : FMY ASIP/PRAS : Complément du texte de l'erreur : "est vide [et sans nullFlavor]" + liste des préfixes admis
        17/03/15 : JDS           : Ajout d'une contrainte sur l'attribut use de telecom (facultatif et valeurs permises)
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="telecom">
    <p>
        Vérification de la conformité au CI-SIS d'un élément telecom (de type TEL) du standard CDAr2 :
        L'élément doit comporter un attribut "value" bien formaté avec les préfixes autorisés par le CI-SIS, 
        et optionnellement un attribut "use" (qui n'est pas contrôlé).
        Alternativement, si l'attribut nullFlavor est présent, il doit avoir l'une des valeurs admises par le CI-SIS. 
    </p>
    <rule context="cda:telecom">
        <let name="prefix" value="substring-before(@value, ':')"/>
        <let name="suffix" value="substring-after(@value, ':')"/>           
        <assert test="(
            (count(@*) = 1 and name(@*) = 'nullFlavor' and
            (@* = 'UNK' or @* = 'NASK' or @* = 'ASKU' or @* = 'NAV' or @* = 'MSK')) or
            ($suffix and (
            $prefix = 'tel' or 
            $prefix = 'fax' or 
            $prefix = 'mailto' or 
            $prefix = 'http' or 
            $prefix = 'ftp' or 
            $prefix = 'mllp'))
            )">
            [telecom.sch] Erreur de conformité CI-SIS : <name/> n'est pas conforme à une adresse de télécommunication préfixe:chaîne 
            (avec préfixe = tel, fax, mailto, http, ftp ou mllp) 
            ou est vide et sans nullFlavor, ou contient un nullFlavor non admis.
        </assert>
        <assert test=" @use = 'H' 
                    or @use = 'HP' 
                    or @use = 'HV' 
                    or @use = 'WP'
                    or @use = 'DIR' 
                    or @use = 'PUB' 
                    or @use = 'EC' 
                    or @use = 'MC' 
                    or @use = 'PG' 
                    or not(@use)">
            [telecom.sch] Erreur de conformité CI-SIS : L'attribut use de l'élément telecom n'est pas conforme. 
            Il est facultatif et les valeurs permises sont 'H','HP', 'HV','WP','DIR','PUB','EC','MC','PG'.
            </assert>
    </rule>
</pattern>