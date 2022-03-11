:: ---------------------------------------------------------------------------------------
:: Execution : verif contenu schema
:: Le fichier ..\..\contenu.xml est validé / au standard (..\..\infrastructure\cda\CDA.xsd),
:: puis vérifié sémantiquement suivant le schématron ..\schema.xsl
:: Le moteur xslt2 utilise est  saxon9he.jar, open source ecrit en java
:: Le resultat est produit dans un rapport au standard svrl : ..\rapports\contenu_verif.xml
:: Le rapport est visualisable dans n'importe quel navigateur grace a la feuille de style 
:: rapportSchematronToHtml4.xsl qui lui est attachee.
:: ---------------------------------------------------------------------------------------
@echo off
if "%1"=="" goto USAGE
set schema=%2
if "%2"=="" set schema=CI-SIS_StructurationCommuneCDAr2
::echo.
::echo Selection de l'arbre ClinicalDocument dans %1.xml
::@echo on
::java -cp saxon9he.jar net.sf.saxon.Transform -s:..\..\%1.xml -xsl:selectCDA.xsl -o:tmp\%1.xml
::@echo off
echo.
echo Validation du fichier %1.xml par rapport a CDA_extended.xsd
@echo on
::java -jar xsdvalidator-1.2.jar tmp\%1.xml "..\..\infrastructure\cda\CDA_extended.xsd" 1> ..\rapports\%1_validCDA.xml
java -jar xsdvalidator-1.3.jar ..\..\%1.xml "..\..\infrastructure\cda\CDA_extended.xsd" 1> ..\rapports\%1_validCDA.xml
@echo off
echo.
echo Verification du fichier %1.xml
@echo on
::java -cp saxon9he.jar net.sf.saxon.Transform -s:tmp\%1.xml -xsl:..\%schema%.xsl -o:..\rapports\%1_verif.xml
java -cp saxon9he.jar net.sf.saxon.Transform -s:..\..\%1.xml -xsl:..\%schema%.xsl -o:..\rapports\%1_verif.xml
@echo off
echo.
echo Rapport de Verification : ..\rapports\%1_verif.xml
echo.
goto END
:USAGE
echo.
echo USAGE: %0 fichier_a_verifier_sans_extension schematron_sans_extension
echo.
echo le fichier a verifier doit exister avec l'extension xml dans le repertoire ..\.. 
echo le schematron (par defaut CI-SIS_StructurationCommuneCDAr2.xsl) 
echo doit etre sous la forme xslt2 dans le repertoire .. ;
echo le rapport de verification est produit dans le repertoire ..\rapports
echo sous le nom fichier_a_verifier_verif.xml
echo.
:END
