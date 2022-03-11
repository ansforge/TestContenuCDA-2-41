:: ---------------------------------------------------------------------------------------
:: Execution : compilverif contenu schema
:: Le fichier ..\..\contenu.xml est validé / au standard (..\..\infrastructure\cda\CDA.xsd),
:: puis vérifié sémantiquement suivant le schématron ..\schema.xsl
:: Le moteur xslt2 utilise est  saxon9he.jar, open source ecrit en java
:: Le resultat est produit dans un rapport au standard svrl : ..\rapports\contenu_verif.xml
:: Le rapport est visualisable dans n'importe quel navigateur grace a la feuille de style 
:: rapportSchematronToHtml4.xsl qui lui est attachee.
:: Le fichier CDA est vérifié en fonction des profils choisis par l'utilisateur
:: 
:: ---------------------------------------------------------------------------------------
@echo off


if "%1"=="" goto USAGE
::set schema=%2

if "%3"=="" (
	set schema_int_min=IHE_XDS-SD
	set schema_int_body=IHE_PCC
	set schema_fr_min=CI-SIS_StructurationMinimale
	set schema_fr_body=ModelesDeContenuCDA
	
 )
if "%3"=="int_min" (
	
	goto VERIFICATION "profils/IHE_XDS-SD"
)
if "%3"=="int_all" (
	set schema_int_min=IHE_XDS-SD
	set schema_int_body="IHE_PCC"
	
)

 
:: Validation en fonction du schema xsd
echo.
echo Validation du fichier %1.xml par rapport au schema CDA
@echo on
java -jar xsdvalidator-1.3.jar ..\..\%1.xml "..\..\infrastructure\cda\CDA_extended.xsd" 1> ..\rapports\%1_validCDA.xml
@echo off


:VERIFICATION
:: Partie à ne garder qu'en développement
:: Partie à ne garder qu'en développement del colle.sch concret.sch
echo.
echo. 1) precompilation du schematron : collage des include  %~1
@echo on
java -cp saxon9he.jar net.sf.saxon.Transform -s:..\%~1.sch -xsl:iso_dsdl_include.xsl -o:colle.sch
@echo off
echo.
echo 2) precompilation du schematron : expansion des abstract
@echo on
java -cp saxon9he.jar net.sf.saxon.Transform -s:colle.sch -xsl:iso_abstract_expand.xsl -o:concret.sch 
@echo off
echo.
echo 3) compilation en xslt2 : produit %~1.xsl
@echo on
java -cp saxon9he.jar net.sf.saxon.Transform -s:concret.sch -xsl:iso_svrl_for_xslt2.xsl -o:..\%~1.xsl 
@echo off
::
echo.
echo Verification du fichier %1.xml
@echo on
java -cp saxon9he.jar net.sf.saxon.Transform -s:..\..\%1.xml -xsl:..\%~1.xsl -o:..\rapports\%1_verif.xml 
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
