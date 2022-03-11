:: voir_defaut.bat
::
:: commande pour forcer la transformation d'un CDA avec la feuille de style cda_asip.xsl présente dans le répertoire testContenuCDA
:: Le résultat au format html est produit sous le répertoire tmp dans le fichier dont le nom est suffixé par _defaut.html
::
:: usage : java -jar dmpvalidator-1.0.jar -xsl <path to cda.xml> <path to output file (html)> <path to XSL a utiliser pour affichage>
::
java -jar dmpvalidator-1.0.jar -xsl ..\..\%1.xml tmp\%1_defaut.html ..\..\cda_asip.xsl 1>tmp\out.txt 2>tmp\err.txt
start tmp\%1_defaut.html
