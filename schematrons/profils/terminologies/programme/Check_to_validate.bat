for %%f in (..\\to_validate\\*.xml) do (
  set /p val=<%%f
 C:\Users\mpriour\Documents\jdk-15.0.1_windows-x64_bin\jdk-15.0.1\bin\java  -cp ./librairie/* validate.java -i  %%f -s ..\schematron\terminologie.sch -o ../output/%%~nf.svrl  -xsl ../xsl/svrl-to-html.xsl -outputxsl ../output/%%~nf.html


)

cd ..
cd output

copy /b *.html merged2.html
pause